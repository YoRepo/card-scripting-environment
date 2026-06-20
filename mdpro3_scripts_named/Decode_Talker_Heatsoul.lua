--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 解码语者·炽热之魂  (ID: 61245672)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Cyberse
-- ATK 2300 | LINK
-- Setcode: 257
--
-- Effect Text:
-- 属性不同的电子界族怪兽2只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升这张卡所连接区的怪兽数量×500。
-- ②：自己·对方回合，支付1000基本分才能发动。自己抽1张。自己基本分是2000以下的场合，可以再让以下效果适用。
-- ●场上的这张卡除外，除「解码语者·炽热之魂」外的1只连接3以下的电子界族怪兽从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デコード・トーカー・ヒートソウル
function c61245672.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,3,c61245672.lcheck)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c61245672.atkval)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61245672,0))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMING_MAIN_END+TIMING_END_PHASE)
	e2:SetCountLimit(1,61245672)
	e2:SetCost(c61245672.drcost)
	e2:SetTarget(c61245672.drtg)
	e2:SetOperation(c61245672.drop)
	c:RegisterEffect(e2)
end
function c61245672.lcheck(g)
	return g:GetClassCount(Card.GetLinkAttribute)==g:GetCount()
end
function c61245672.atkval(e,c)
	return c:GetLinkedGroupCount()*500
end
function c61245672.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c61245672.cfilter(c,e,tp,mc)
	return c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_LINK) and c:IsLinkBelow(3) and not c:IsCode(61245672)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c61245672.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c61245672.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)~=0 and Duel.GetLP(tp)<=2000 and c:IsRelateToEffect(e) and c:IsAbleToRemove()
		and Duel.IsExistingMatchingCard(c61245672.cfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
		and Duel.SelectYesNo(tp,aux.Stringid(61245672,1)) then
		Duel.BreakEffect()
		if Duel.Remove(c,POS_FACEUP,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_REMOVED) then
			local g=Duel.SelectMatchingCard(tp,c61245672.cfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
