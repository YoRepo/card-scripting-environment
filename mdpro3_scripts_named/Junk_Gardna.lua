--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 废品守卫者  (ID: 37993923)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 1400 | DEF 2600
-- Setcode: 67
--
-- Effect Text:
-- 「废品同调士」＋调整以外的怪兽1只以上
-- 1回合1次，可以选择对方场上存在的1只怪兽，把表示形式变更。这个效果在对方回合也能发动。此外，这张卡从场上送去墓地的场合，可以选择场上存在的1只怪兽，把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--ジャンク・ガードナー
function c37993923.initial_effect(c)
	aux.AddMaterialCodeList(c,63977008)
	--synchro summon
	aux.AddSynchroProcedure(c,c37993923.tfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37993923,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c37993923.target)
	e1:SetOperation(c37993923.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37993923,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c37993923.condition2)
	e2:SetTarget(c37993923.target2)
	e2:SetOperation(c37993923.operation)
	c:RegisterEffect(e2)
end
c37993923.material_setcode=0x1017
function c37993923.tfilter(c)
	return c:IsCode(63977008) or c:IsHasEffect(20932152)
end
function c37993923.filter(c)
	return c:IsCanChangePosition()
end
function c37993923.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c37993923.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37993923.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c37993923.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c37993923.condition2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c37993923.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c37993923.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c37993923.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c37993923.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c37993923.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
