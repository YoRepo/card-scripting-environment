--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 捕食植物 露松水螅龙  (ID: 99913726)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 5
-- ATK 800 | DEF 2300
-- Setcode: 4339
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：这张卡把自己或者对方场上1只有捕食指示物放置的怪兽解放的场合可以从手卡·墓地特殊召唤。
-- ②：这张卡在场上·墓地存在的场合，把这张卡以外的自己墓地1只「捕食植物」怪兽除外，以场上1只表侧表示怪兽为对象才能发动。那只怪兽的攻击力下降500。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--捕食植物ドロソフィルム・ヒドラ
function c99913726.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,99913726+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c99913726.hspcon)
	e1:SetTarget(c99913726.hsptg)
	e1:SetOperation(c99913726.hspop)
	c:RegisterEffect(e1)
	--atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99913726,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCountLimit(1,99913727)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCondition(aux.dscon)
	e2:SetCost(c99913726.atkcost)
	e2:SetTarget(c99913726.atktg)
	e2:SetOperation(c99913726.atkop)
	c:RegisterEffect(e2)
end
function c99913726.rfilter(c,tp)
	return c:GetCounter(0x1041)>0 and c:IsReleasable(REASON_SPSUMMON)
		and Duel.GetMZoneCount(tp,c)>0
end
function c99913726.hspcon(e,c)
	if c==nil then return true end
	if c:IsHasEffect(EFFECT_NECRO_VALLEY) then return false end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c99913726.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp)
end
function c99913726.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c99913726.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c99913726.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
function c99913726.cfilter(c)
	return c:IsSetCard(0x10f3) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c99913726.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c99913726.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c99913726.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c99913726.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c99913726.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-500)
		tc:RegisterEffect(e1)
	end
end
