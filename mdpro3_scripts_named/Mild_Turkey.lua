--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 温火鸡  (ID: 47558785)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Winged Beast
-- Level 4
-- Pendulum Scales: L7 / R7
-- ATK 1000 | DEF 2000
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- ①：1回合1次，自己主要阶段才能发动。掷1次骰子。直到回合结束时，这张卡的灵摆刻度下降出现的数目数值（最少到1）。
-- 【怪兽描述】
-- 对保龄球的热情烤焦全身的狂放火鸡。为了拿到全中而锻炼出来的身体，经常散发出极品的香味。以还没见到的火鸡球作为目标，每天不间断地练习着。
--[[ __CARD_HEADER_END__ ]]

--マイルド・ターキー
function c47558785.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47558785,0))
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c47558785.sctg)
	e1:SetOperation(c47558785.scop)
	c:RegisterEffect(e1)
end
function c47558785.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetLeftScale()>1 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c47558785.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:GetLeftScale()<=1 then return end
	local dc=Duel.TossDice(tp,1)
	local sch=math.min(c:GetLeftScale()-1,dc)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LSCALE)
	e1:SetValue(-sch)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_RSCALE)
	c:RegisterEffect(e2)
end
