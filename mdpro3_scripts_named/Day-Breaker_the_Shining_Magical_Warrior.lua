--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Day-Breaker the Shining Magical Warrior  (ID: 91336701)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Spellcaster
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 1600
-- Setcode: 0x6e
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Spellcaster monsters
-- If this card is Link Summoned: Place 1 Spell Counter on it.
-- Gains 300 ATK for each Spell Counter on it.
-- You can only activate each of the following effects of "Day-Breaker the Shining Magical Warrior"
-- once per turn.
-- ● If a Spellcaster monster(s) is Special Summoned to a zone(s) this card points to: Place 1 Spell
-- Counter on this card.
-- ● You can remove 2 Spell Counters from this card, then target 1 card on the field; destroy it.
--[[ __CARD_HEADER_END__ ]]

--魔導耀士 デイブレイカー
function c91336701.initial_effect(c)
	c:EnableCounterPermit(0x1)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_SPELLCASTER),2,2)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91336701,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c91336701.ctcon1)
	e1:SetTarget(c91336701.cttg)
	e1:SetOperation(c91336701.ctop)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91336701,1))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,91336701)
	e2:SetCondition(c91336701.ctcon2)
	e2:SetTarget(c91336701.cttg)
	e2:SetOperation(c91336701.ctop)
	c:RegisterEffect(e2)
	--attackup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c91336701.atkval)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(91336701,2))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,91336702)
	e4:SetCost(c91336701.descost)
	e4:SetTarget(c91336701.destg)
	e4:SetOperation(c91336701.desop)
	c:RegisterEffect(e4)
end
function c91336701.ctcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c91336701.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x1)
end
function c91336701.ctop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c91336701.cfilter(c,g)
	return c:IsFaceup() and g:IsContains(c) and c:IsRace(RACE_SPELLCASTER)
end
function c91336701.ctcon2(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetLinkedGroup()
	return lg and eg:IsExists(c91336701.cfilter,1,nil,lg)
end
function c91336701.atkval(e,c)
	return c:GetCounter(0x1)*300
end
function c91336701.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x1,2,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x1,2,REASON_COST)
end
function c91336701.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c91336701.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
