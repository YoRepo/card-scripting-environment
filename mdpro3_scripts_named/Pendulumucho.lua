--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 灵摆多福鸟  (ID: 18210764)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Winged Beast
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 242
--
-- Effect Text:
-- ←0 【灵摆】 0→
-- ①：这张卡发动的回合的自己主要阶段只有1次，从自己墓地的怪兽或者除外的自己怪兽之中以「灵摆多福鸟」以外的1只灵摆怪兽为对象才能发动。那只灵摆怪兽表侧表示加入自己的额外卡组。
-- 【怪兽效果】
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从自己的额外卡组把「灵摆多福鸟」以外的1只表侧表示的1星灵摆怪兽特殊召唤。这个效果特殊召唤的怪兽从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--ペンデュラムーチョ
function c18210764.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(1160)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c18210764.reg)
	c:RegisterEffect(e1)
	--toextra
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18210764,0))
	e2:SetCategory(CATEGORY_TOEXTRA)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c18210764.tecon)
	e2:SetTarget(c18210764.tetg)
	e2:SetOperation(c18210764.teop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(18210764,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetTarget(c18210764.sptg)
	e3:SetOperation(c18210764.spop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c18210764.reg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(18210764,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c18210764.tecon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(18210764)>0
end
function c18210764.tefilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsType(TYPE_PENDULUM)
		and not c:IsCode(18210764)
end
function c18210764.tetg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c18210764.tefilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c18210764.tefilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(18210764,1))
	local g=Duel.SelectTarget(tp,c18210764.tefilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,g,1,0,0)
	if g:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	end
end
function c18210764.teop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoExtraP(tc,nil,REASON_EFFECT)
	end
end
function c18210764.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsLevel(1)
		and not c:IsCode(18210764) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c18210764.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c18210764.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c18210764.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c18210764.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		g:GetFirst():RegisterEffect(e1,true)
	end
end
