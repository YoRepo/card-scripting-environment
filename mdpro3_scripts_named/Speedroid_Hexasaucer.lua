--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 疾行机人 六角飞盘  (ID: 23792058)
-- Type: Monster / Effect / Pendulum
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- Pendulum Scales: L6 / R6
-- ATK 100 | DEF 1600
-- Setcode: 8214
--
-- Effect Text:
-- ←6 【灵摆】 6→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：从自己墓地的怪兽以及除外的自己怪兽之中以1只风属性同调怪兽为对象才能发动。那只怪兽回到额外卡组。
-- 【怪兽效果】
-- ①：这张卡的战斗发生的战斗伤害由双方玩家承受。
-- ②：这张卡的战斗发生的双方的战斗伤害变成一半。
-- ③：这张卡在灵摆区域被破坏的场合才能发动。从自己的额外卡组把1只表侧表示的「疾行机人」灵摆怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--SRヘキサソーサー
function c23792058.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to extra
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23792058,0))
	e1:SetCategory(CATEGORY_TOEXTRA)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,23792058)
	e1:SetTarget(c23792058.tdtg)
	e1:SetOperation(c23792058.tdop)
	c:RegisterEffect(e1)
	--damage
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_BOTH_BATTLE_DAMAGE)
	c:RegisterEffect(e0)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_INVOLVING_BATTLE_DAMAGE)
	e2:SetValue(HALF_DAMAGE)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c23792058.spcon)
	e3:SetTarget(c23792058.sptg)
	e3:SetOperation(c23792058.spop)
	c:RegisterEffect(e3)
end
function c23792058.tdfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
		and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c23792058.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c23792058.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23792058.tdfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c23792058.tdfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c23792058.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c23792058.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_PZONE)
end
function c23792058.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x2016)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c23792058.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c23792058.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c23792058.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c23792058.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
