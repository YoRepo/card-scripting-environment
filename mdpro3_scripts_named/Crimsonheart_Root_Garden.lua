--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T00:00:00
-- Card: Crimsonheart Root Garden  (ID: 211050)
-- Type: Spell / Field
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- You can only use the (2) effect of "Crimsonheart Root Garden" once per turn.
-- (1) Once per turn, if your opponent Special Summons a monster(s): You can target 1 of those monsters;
-- Set 1 "Crimsonheart" Trap directly from your Deck, and if you do, it can be activated this turn as long
-- as that target is face-up on the field.
-- (2) If this card is sent to the GY: You can place this card in your Field Zone face-up, but banish it
-- when it leaves the field.
--[[ __CARD_HEADER_END__ ]]

--Crimsonheart Root Garden
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--(1) if opponent Special Summons: target 1; Set 1 "Crimsonheart" Trap from Deck (activatable this turn)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.setcon)
	e1:SetTarget(s.settg)
	e1:SetOperation(s.setop)
	c:RegisterEffect(e1)
	--(2) if sent to GY: place this card in your Field Zone face-up; banish it when it leaves the field
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.pltg)
	e2:SetOperation(s.plop)
	c:RegisterEffect(e2)
end
--(1)
function s.cfilter(c,tp)
	return c:IsControler(1-tp) and c:IsFaceup() and c:IsLocation(LOCATION_MZONE)
end
function s.setcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.setfilter(c)
	return c:IsSetCard(0x95c) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and s.cfilter(chkc,tp) end
	if chk==0 then return eg:IsExists(s.cfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(s.setfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=eg:FilterSelect(tp,s.cfilter,1,1,nil,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SSET,nil,1,tp,LOCATION_DECK)
end
function s.actcon(e)
	local mc=e:GetLabelObject()
	return mc and mc:IsFaceup() and mc:IsLocation(LOCATION_MZONE)
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local mc=Duel.GetFirstTarget()
	if not (mc and mc:IsRelateToEffect(e) and mc:IsFaceup() and mc:IsLocation(LOCATION_MZONE)) then return end
	local g=Duel.GetMatchingGroup(s.setfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local tc=g:Select(tp,1,1,nil):GetFirst()
	if tc and Duel.SSet(tp,tc)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetLabelObject(mc)
		e1:SetCondition(s.actcon)
		tc:RegisterEffect(e1)
	end
end
--(2)
function s.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLocation(LOCATION_GRAVE)
		and not e:GetHandler():IsForbidden() and e:GetHandler():CheckUniqueOnField(tp) end
end
function s.plop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsLocation(LOCATION_GRAVE) then return end
	local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if fc then
		Duel.SendtoGrave(fc,REASON_RULE)
		Duel.BreakEffect()
	end
	if Duel.MoveToField(c,tp,tp,LOCATION_FZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1)
	end
end
