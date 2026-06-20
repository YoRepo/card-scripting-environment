--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 宝石骑士女郎·亮钻  (ID: 19355597)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 10
-- ATK 3400 | DEF 2000
-- Setcode: 4167
--
-- Effect Text:
-- 「宝石骑士」怪兽×3
-- 这张卡用以上记的卡为融合素材的融合召唤才能从额外卡组特殊召唤。自己对「宝石骑士女郎·亮钻」1回合只能有1次特殊召唤。
-- ①：1回合1次，自己主要阶段才能发动。自己场上1只表侧表示的「宝石骑士」怪兽送去墓地，从额外卡组把1只「宝石骑士」融合怪兽无视召唤条件特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ジェムナイトレディ・ブリリアント・ダイヤ
function c19355597.initial_effect(c)
	c:SetSPSummonOnce(19355597)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1047),3,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c19355597.splimit)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c19355597.sptg)
	e2:SetOperation(c19355597.spop)
	c:RegisterEffect(e2)
end
function c19355597.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA) or bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c19355597.tgfilter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x1047)
		and Duel.IsExistingMatchingCard(c19355597.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c19355597.spfilter(c,e,tp,tc)
	return c:IsSetCard(0x1047) and c:IsType(TYPE_FUSION)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCountFromEx(tp,tp,tc,c)>0
end
function c19355597.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19355597.tgfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c19355597.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=Duel.SelectMatchingCard(tp,c19355597.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local tc=tg:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c19355597.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
