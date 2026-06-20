--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 运否之天赋罗-虾  (ID: 86304179)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Aqua
-- Level 3
-- Pendulum Scales: L8 / R8
-- ATK 1600 | DEF 0
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：以自己的灵摆区域1张卡为对象才能发动。进行1次投掷硬币，那个里表的以下效果适用。
-- ●表：那张卡特殊召唤。
-- ●里：那张卡破坏，自己失去那个灵摆刻度×300基本分。
-- 【怪兽描述】
-- 走进话题火爆的江户前线(EDO－FRONT)。这里的天赋罗不仅尺度之大不用多说，其富有美感的造型还甚至享有「金赋罗」的异名。港内虽然满是最新锐设备和异文化感，却又飘散着莫名感到怀念的醇香，时而劈啪作响
-- 的轻快音色令人心都酥炸了。期盼已久的天赋罗，可惜今天因为周边空域要变天的影响而一律不入港……。虽说是运气差，但连这后面的预定也不得不就此取消。正因为满心期待了1年才更感到特别遗憾，不过就这次的应对态度
-- 来说，我认为给3颗星是妥当的。
--[[ __CARD_HEADER_END__ ]]

--運否の天賦羅－EBI
local s,id,o=GetID()
function s.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.cotg)
	e1:SetOperation(s.coop)
	c:RegisterEffect(e1)
end
s.toss_coin=true
function s.cofilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function s.cotg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) and s.cofilter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.cofilter,tp,LOCATION_PZONE,0,1,nil,e,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,s.cofilter,tp,LOCATION_PZONE,0,1,1,nil,e,tp)
end
function s.coop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local c1=Duel.TossCoin(tp,1)
	if c1==1 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	elseif c1==0 then
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			local lp=Duel.GetLP(tp)
			Duel.SetLP(tp,lp-tc:GetCurrentScale()*300)
		end
	end
end
