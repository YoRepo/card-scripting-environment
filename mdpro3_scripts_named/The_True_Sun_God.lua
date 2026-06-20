--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 真正的太阳神  (ID: 11587414)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，除「真正的太阳神」外的1只「太阳神之翼神龙」或者1张有那个卡名记述的卡从卡组加入手卡。
-- ②：「太阳神之翼神龙」以外的特殊召唤的怪兽在那个回合不能攻击。
-- ③：1回合1次，自己主要阶段才能发动。这张卡或者卡组1只「太阳神之翼神龙-不死鸟」送去墓地。那之后，选自己场上1只「太阳神之翼神龙」送去墓地。
--[[ __CARD_HEADER_END__ ]]

--真なる太陽神
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,10000010)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(s.attg)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(s.tgtg)
	e3:SetOperation(s.tgop)
	c:RegisterEffect(e3)
end
function s.filter(c)
	return aux.IsCodeOrListed(c,10000010) and not c:IsCode(id) and c:IsAbleToHand()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.attg(e,c)
	return c:IsStatus(STATUS_SPSUMMON_TURN) and not c:IsCode(10000010)
end
function s.tgfilter1(c)
	return c:IsAbleToGrave() and c:IsCode(10000090)
end
function s.tgfilter2(c)
	return c:IsAbleToGrave() and c:IsCode(10000010) and c:IsFaceup()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return (e:GetHandler():IsAbleToGrave()
			or Duel.IsExistingMatchingCard(s.tgfilter1,tp,LOCATION_DECK,0,1,nil))
		and Duel.IsExistingMatchingCard(s.tgfilter2,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_MZONE+LOCATION_DECK)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(s.tgfilter1,tp,LOCATION_DECK,0,nil)
	if c:IsRelateToChain() and c:IsAbleToGrave() then g:AddCard(c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg1=g:Select(tp,1,1,nil)
	if Duel.SendtoGrave(sg1,REASON_EFFECT)>0 and sg1:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg2=Duel.SelectMatchingCard(tp,s.tgfilter2,tp,LOCATION_MZONE,0,1,1,nil)
		if #sg2>0 then
			Duel.BreakEffect()
			Duel.SendtoGrave(sg2,REASON_EFFECT)
		end
	end
end
