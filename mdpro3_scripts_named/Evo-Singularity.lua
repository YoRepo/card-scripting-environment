--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 进化的特异点  (ID: 74100225)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以自己墓地1只「进化虫」怪兽和1只「进化龙」怪兽为对象才能发动。从额外卡组把1只「进化帝」超量怪兽特殊召唤，把作为对象的怪兽作为那只超量怪兽的超量素材。
--[[ __CARD_HEADER_END__ ]]

--進化の特異点
function c74100225.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c74100225.target)
	e1:SetOperation(c74100225.activate)
	c:RegisterEffect(e1)
end
function c74100225.filter(c,cat)
	return c:IsSetCard(cat) and c:IsType(TYPE_MONSTER) and c:IsCanOverlay()
end
function c74100225.spfilter(c,e,tp)
	return c:IsSetCard(0x504e) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c74100225.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c74100225.filter,tp,LOCATION_GRAVE,0,1,nil,0x304e)
		and Duel.IsExistingTarget(c74100225.filter,tp,LOCATION_GRAVE,0,1,nil,0x604e)
		and Duel.IsExistingMatchingCard(c74100225.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g1=Duel.SelectTarget(tp,c74100225.filter,tp,LOCATION_GRAVE,0,1,1,nil,0x304e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g2=Duel.SelectTarget(tp,c74100225.filter,tp,LOCATION_GRAVE,0,1,1,nil,0x604e)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g1,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c74100225.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c74100225.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local sc=sg:GetFirst()
	if sc and Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)>0 then
		local mg=Duel.GetTargetsRelateToChain()
		if #mg>0 then
			Duel.Overlay(sc,mg)
		end
	end
end
