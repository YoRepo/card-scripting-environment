--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 双天脚 铠吽  (ID: 7631534)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 5
-- ATK 1700 | DEF 2100
-- Setcode: 335
--
-- Effect Text:
-- 「双天」怪兽×2
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：自己场上的「双天」融合怪兽被效果破坏的场合，可以作为代替把自己场上1只「双天」怪兽破坏。
-- ②：效果怪兽为素材作融合召唤的「双天」融合怪兽在自己场上存在的场合，自己·对方的主要阶段，以从额外卡组特殊召唤的1只表侧表示怪兽为对象才能发动。那只怪兽的效果直到回合结束时无效。
--[[ __CARD_HEADER_END__ ]]

--双天脚 鎧吽
function c7631534.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x14f),2,true)
	--effect monster material check
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_MATERIAL_CHECK)
	e0:SetValue(c7631534.matcheck)
	c:RegisterEffect(e0)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c7631534.reptg)
	e1:SetValue(c7631534.repval)
	e1:SetOperation(c7631534.repop)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7631534,0))
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMING_MAIN_END)
	e2:SetCountLimit(1,7631534)
	e2:SetCondition(c7631534.discon)
	e2:SetTarget(c7631534.distg)
	e2:SetOperation(c7631534.disop)
	c:RegisterEffect(e2)
end
function c7631534.matcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsType,1,nil,TYPE_EFFECT) then
		c:RegisterFlagEffect(85360035,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD,0,1)
	end
end
function c7631534.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x14f) and c:IsType(TYPE_FUSION) and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c7631534.desfilter(c,e,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x14f)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c7631534.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c7631534.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c7631534.desfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c7631534.desfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	end
	return false
end
function c7631534.repval(e,c)
	return c7631534.repfilter(c,e:GetHandlerPlayer())
end
function c7631534.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,7631534)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
function c7631534.fmfilter(c)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x14f) and c:IsFaceup() and c:GetFlagEffect(85360035)~=0
end
function c7631534.discon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
		and Duel.IsExistingMatchingCard(c7631534.fmfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c7631534.disfilter(c)
	return aux.NegateMonsterFilter(c) and c:IsSummonLocation(LOCATION_EXTRA)
end
function c7631534.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c7631534.disfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7631534.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local g=Duel.SelectTarget(tp,c7631534.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c7631534.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
