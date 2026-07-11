--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Heart of Gaia  (ID: 73129314)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 2300 | DEF 2100
-- Setcode: 0x1ae, 0xbd
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is always treated as a "Millennium" and "Gaia The Fierce Knight" card.)
-- If a Level 5 or higher Monster Card is on the field, you can Normal Summon this card without
-- Tributing.
-- The Level of any monster your opponent Normal or Special Summons in Attack Position, while this card
-- is in your Monster Zone, is increased by 7.
-- When your opponent activates a monster effect (Quick Effect): You can send 1 other face-up Level 5
-- or higher Monster Card you control to the GY; negate the activation, and if you do, destroy that
-- card.
-- You can only use this effect of "Heart of Gaia" once per turn.
--[[ __CARD_HEADER_END__ ]]

--魂宿りし暗黒騎士ガイア
local s,id,o=GetID()
function s.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(s.ntcon)
	c:RegisterEffect(e1)
	--lv up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(s.lvcon)
	e2:SetOperation(s.lvop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetCode(EVENT_CHAINING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1,id)
	e4:SetCondition(s.negcon)
	e4:SetCost(s.negcost)
	e4:SetTarget(s.negtg)
	e4:SetOperation(s.negop)
	c:RegisterEffect(e4)
end
function s.cfilter(c)
	return c:IsFaceup() and c:GetOriginalType()&TYPE_MONSTER==TYPE_MONSTER
		and (c:IsLevelAbove(5) and c:IsLocation(LOCATION_MZONE)
		or c:GetOriginalLevel()>4 and not c:IsLocation(LOCATION_MZONE))
end
function s.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.cfilter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
end
function s.lvcfilter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsLevelAbove(1) and c:IsPosition(POS_FACEUP_ATTACK) and c:IsLocation(LOCATION_MZONE)
end
function s.lvcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.lvcfilter,1,nil,1-tp) and not eg:IsContains(e:GetHandler())
end
function s.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(s.lvcfilter,nil,1-tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_CARD,0,id)
		for tc in aux.Next(g) do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_LEVEL)
			e1:SetValue(7)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1)
		end
	end
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and rp==1-tp and Duel.IsChainNegatable(ev)
end
function s.costfilter(c)
	return c:IsFaceup() and c:GetOriginalType()&TYPE_MONSTER==TYPE_MONSTER
		and (c:IsLevelAbove(5) and c:IsLocation(LOCATION_MZONE)
		or c:GetOriginalLevel()>4 and not c:IsLocation(LOCATION_MZONE))
		and c:IsAbleToGraveAsCost()
end
function s.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.costfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
