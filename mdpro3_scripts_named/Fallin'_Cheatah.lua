--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 坠入情网的猎豹  (ID: 59011257)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level 3
-- ATK 1100 | DEF 2200
--
-- Effect Text:
-- ①：这张卡只要在怪兽区域存在，不能解放，也不能作为融合·同调·超量·连接召唤的素材。
-- ②：这张卡在怪兽区域存在的状态，对方场上有怪兽特殊召唤的场合，以那之内的1只为对象发动。这张卡的控制权移给作为对象的怪兽的控制者。这只怪兽表侧表示存在期间，作为对象的怪兽不能解放，也不能作为融合·同调
-- ·超量·连接召唤的素材。
--[[ __CARD_HEADER_END__ ]]

--フォーリンチーター
local s,id,o=GetID()
function s.initial_effect(c)
	--cannot release
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(s.fuslimit)
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e5)
	local e6=e1:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(e6)
	--control
	local custom_code=aux.RegisterMergedDelayedEvent_ToSingleCard(c,id,EVENT_SPSUMMON_SUCCESS)
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(id,1))
	e7:SetCategory(CATEGORY_CONTROL)
	e7:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(custom_code)
	e7:SetCondition(s.ctcon)
	e7:SetTarget(s.cttg)
	e7:SetOperation(s.ctop)
	c:RegisterEffect(e7)
end
function s.fuslimit(e,c,sumtype)
	return sumtype==SUMMON_TYPE_FUSION
end
function s.filter(c,e,tp)
	return c:IsControler(1-tp)
end
function s.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.filter,1,nil,nil,tp)
end
function s.indfilter(c,g,tp,ec)
	return c:IsControler(1-tp) and g:IsContains(c) and ec:IsControlerCanBeChanged()
end
function s.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(1-tp) and eg:IsContains(chkc) and c:IsControlerCanBeChanged() end
	if chk==0 then return true end
	Duel.SelectTarget(tp,s.indfilter,tp,0,LOCATION_MZONE,1,1,nil,eg,tp,c)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function s.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToChain() and tc and tc:IsRelateToChain() and tc:IsType(TYPE_MONSTER) then
		if tc:IsControler(1-tp) then
			Duel.GetControl(c,1-tp)
		end
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(s.nrcon)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
		e3:SetValue(s.fuslimit)
		tc:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		tc:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
		tc:RegisterEffect(e5)
		local e6=e1:Clone()
		e6:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		tc:RegisterEffect(e6)
	end
end
function s.nrcon(e)
	return e:GetOwner():IsHasCardTarget(e:GetHandler())
end
