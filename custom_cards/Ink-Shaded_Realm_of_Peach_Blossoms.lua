--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shaded Realm of Peach Blossoms  (ID: 99811080)
-- Type: Spell / Field
-- Setcode: 0x1961 (Ink-Shaded)
--
-- Effect Text:
-- You can only use the ①③ effects of "Ink-Shaded Realm of Peach Blossoms" once per turn each.
-- ① When this card is activated: You can add 1 "Ink Shader" monster from your Deck or GY to your hand.
-- ② "Ink-Shaded" monsters on the field gain 100 ATK for each banished "Ink-Shade" Spell/Trap.
-- ③ If this card is sent to the GY: You can place it in your opponent's Field Zone face-up, but banish
-- it when it leaves the field.
--[[ __CARD_HEADER_END__ ]]

--Ink-Shaded Realm of Peach Blossoms
local s,id,o=GetID()
function s.initial_effect(c)
	--(1) when this card is activated: you can add 1 "Ink Shader" monster from Deck/GY to hand
	--(the once-per-turn rides on the activation, as every real Field Spell with this wording is scripted:
	--cf. Duel Evolution - Assault Zone, Perfect Sync - A-Un)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--(2) "Ink-Shaded" monsters on the field gain 100 ATK for each banished "Ink-Shade" Spell/Trap
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1961))
	e2:SetValue(s.atkval)
	c:RegisterEffect(e2)
	--(3) if this card is sent to the GY: place it in your opponent's Field Zone face-up; banish it when it leaves the field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,id+o)
	e3:SetTarget(s.pltg)
	e3:SetOperation(s.plop)
	c:RegisterEffect(e3)
end
--(1)
function s.thfilter(c)
	return c:IsSetCard(0x960) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
--(2)
--"each banished": either player's; a face-down banished card has no name
function s.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function s.atkval(e,c)
	return Duel.GetMatchingGroupCount(s.atkfilter,e:GetHandlerPlayer(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*100
end
--(3) (cf. Vaylantz World - Konig Wissen for the opponent's Field Zone, Crimsonheart Root Garden for the redirect)
function s.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsForbidden() and c:CheckUniqueOnField(1-tp) end
	--this card leaves the GY: declared so that Necrovalley can negate it (cf. Witchcrafter Bystreet)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,c,1,0,0)
end
function s.plop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() then return end
	local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
	if fc then
		Duel.SendtoGrave(fc,REASON_RULE)
		Duel.BreakEffect()
	end
	if Duel.MoveToField(c,tp,1-tp,LOCATION_FZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end
