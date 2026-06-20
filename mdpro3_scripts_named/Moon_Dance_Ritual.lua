--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 月舞的仪式  (ID: 14005031)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以自己场上1只没有超量素材的风属性超量怪兽为对象才能把这张卡发动。只要那只怪兽在场上存在，场上的表侧表示怪兽的效果无效化。作为对象的怪兽从场上离开时这张卡破坏。
-- ②：这张卡发动的回合的结束阶段发动。把场上的这张卡在这张卡的发动时作为对象的怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--ムーンダンスの儀式
function c14005031.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(c14005031.target)
	e1:SetOperation(c14005031.activate)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c14005031.disable)
	e2:SetCondition(c14005031.discon)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c14005031.descon)
	e3:SetOperation(c14005031.desop)
	c:RegisterEffect(e3)
end
function c14005031.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()==0 and c:IsAttribute(ATTRIBUTE_WIND)
end
function c14005031.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c14005031.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14005031.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c14005031.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c14005031.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(14005031,0))
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCountLimit(1)
		e1:SetOperation(c14005031.matop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c14005031.disable(e,c)
	return c:IsType(TYPE_EFFECT) or bit.band(c:GetOriginalType(),TYPE_EFFECT)==TYPE_EFFECT
end
function c14005031.discon(e)
	return e:GetHandler():GetFirstCardTarget()~=nil
end
function c14005031.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c14005031.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c14005031.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if tc then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
