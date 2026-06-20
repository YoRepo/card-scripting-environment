--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 群豪之统治者-公爵  (ID: 13291886)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Machine
-- Level 8
-- Pendulum Scales: L1 / R1
-- ATK 2000 | DEF 2000
-- Setcode: 381
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：场地区域有「群豪世界-百识公国」存在的场合或者自己场上有炎属性「群豪」怪兽存在的场合才能发动。这张卡在正对面的自己的主要怪兽区域特殊召唤。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：以魔法与陷阱区域盖放的1张卡为对象才能发动。盖放的那张卡在这个回合不能发动。
-- ②：怪兽区域的这张卡向其他的怪兽区域移动的场合，以对方的主要怪兽区域1只表侧表示怪兽为对象才能发动。得到那只表侧表示怪兽的控制权。这个效果得到控制权的怪兽不能攻击宣言，不能把效果发动，也当作「群豪」怪
-- 兽使用。
--[[ __CARD_HEADER_END__ ]]

--ヴァリアンツD－デューク
function c13291886.initial_effect(c)
	aux.AddCodeList(c,75952542)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,13291886)
	e1:SetCondition(c13291886.spcon)
	e1:SetTarget(c13291886.sptg)
	e1:SetOperation(c13291886.spop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,13291887)
	e2:SetTarget(c13291886.altg)
	e2:SetOperation(c13291886.alop)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_MOVE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,13291888)
	e3:SetCondition(c13291886.mvcon)
	e3:SetTarget(c13291886.mvtg)
	e3:SetOperation(c13291886.mvop)
	c:RegisterEffect(e3)
end
function c13291886.cfilter(c)
	return c:IsSetCard(0x17d) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsFaceup()
end
function c13291886.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(75952542) or Duel.IsExistingMatchingCard(c13291886.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c13291886.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c13291886.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c13291886.alfilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c13291886.altg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c13291886.alfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13291886.alfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(13291886,0))
	Duel.SelectTarget(tp,c13291886.alfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
end
function c13291886.alop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c13291886.mvcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_MZONE)
		and (c:GetPreviousSequence()~=c:GetSequence() or c:GetPreviousControler()~=tp)
end
function c13291886.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged() and c:GetSequence()<=4
end
function c13291886.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c13291886.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13291886.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c13291886.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c13291886.mvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.GetControl(tc,tp)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_ADD_SETCODE)
		e3:SetValue(0x17d)
		tc:RegisterEffect(e3)
	end
end
