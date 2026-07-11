--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Return of the Monarchs  (ID: 61466310)
-- Type: Spell / Continuous
-- Setcode: 0xbe
-- Scope: OCG / TCG
--
-- Effect Text:
-- You cannot Special Summon from the Extra Deck.
-- When you Tribute Summon a monster: You can activate 1 of these effects;
-- ● Add, from your Deck to your hand, 1 monster with 2400 ATK/1000 DEF with a different name from that
-- Tribute Summoned monster.
-- ● Add, from your Deck to your hand, 1 monster with 2800 ATK/1000 DEF with a different name from that
-- Tribute Summoned monster.
-- The Tribute Summoned monster must be face-up on the field to activate and to resolve this effect.
-- You can only use this effect of "Return of the Monarchs" once per turn.
--[[ __CARD_HEADER_END__ ]]

--帝王の開岩
function c61466310.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c61466310.sumlimit)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(61466310,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,61466310)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c61466310.thcon)
	e3:SetTarget(c61466310.thtg)
	e3:SetOperation(c61466310.thop)
	c:RegisterEffect(e3)
end
function c61466310.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_EXTRA)
end
function c61466310.thcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and eg:GetFirst():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c61466310.filter(c,code)
	return c:IsAttack(2400,2800) and c:IsDefense(1000) and not c:IsCode(code) and c:IsAbleToHand()
end
function c61466310.filter2(c,atk,code)
	return c:IsAttack(atk) and c:IsDefense(1000) and not c:IsCode(code) and c:IsAbleToHand()
end
function c61466310.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c61466310.filter,tp,LOCATION_DECK,0,1,nil,eg:GetFirst():GetCode()) end
	local t1=Duel.IsExistingMatchingCard(c61466310.filter2,tp,LOCATION_DECK,0,1,nil,2400,eg:GetFirst():GetCode())
	local t2=Duel.IsExistingMatchingCard(c61466310.filter2,tp,LOCATION_DECK,0,1,nil,2800,eg:GetFirst():GetCode())
	if t1 and t2 then e:SetLabel(Duel.SelectOption(tp,aux.Stringid(61466310,1),aux.Stringid(61466310,2)))
	elseif t1 then e:SetLabel(Duel.SelectOption(tp,aux.Stringid(61466310,1)))
	else e:SetLabel(Duel.SelectOption(tp,aux.Stringid(61466310,2))+1) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	eg:GetFirst():CreateEffectRelation(e)
end
function c61466310.thop(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	if ec:IsFacedown() or not ec:IsRelateToEffect(e) then return end
	local atk=e:GetLabel()==0 and 2400 or 2800
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c61466310.filter2,tp,LOCATION_DECK,0,1,1,nil,atk,ec:GetCode())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
