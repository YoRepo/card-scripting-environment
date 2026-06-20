--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 德拉科尼亚的海龙骑兵  (ID: 82114013)
-- Type: Monster / Normal / Pendulum
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 3
-- Pendulum Scales: L7 / R7
-- ATK 200 | DEF 2100
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- 「德拉科尼亚的海龙骑兵」的灵摆效果1回合只能使用1次。
-- ①：自己或者对方的怪兽被战斗破坏时才能发动。从手卡把1只通常怪兽特殊召唤。
-- 【怪兽描述】
-- 龙人族国家德拉科尼亚帝国所拥有的龙骑士团海兵部队。擅长从深海里无声无息地偷偷靠近的隐秘作战。跟对岸的迪隆公国兵之间处于围绕领海不断发生小冲突的状态。
--[[ __CARD_HEADER_END__ ]]

--ドラコニアの海竜騎兵
function c82114013.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1,82114013)
	e2:SetTarget(c82114013.sptg)
	e2:SetOperation(c82114013.spop)
	c:RegisterEffect(e2)
end
function c82114013.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c82114013.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c82114013.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c82114013.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c82114013.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
