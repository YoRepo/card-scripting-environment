--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 古代的机械热核龙  (ID: 44874522)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 9
-- ATK 3000 | DEF 3000
-- Setcode: 6488071
--
-- Effect Text:
-- ①：把「古代的机械」怪兽解放作上级召唤的这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ②：把「零件」怪兽解放作上级召唤的这张卡在同1次的战斗阶段中可以作2次攻击。
-- ③：这张卡攻击的场合，对方直到伤害步骤结束时怪兽的效果·魔法·陷阱卡不能发动。
-- ④：这张卡攻击的伤害步骤结束时才能发动。选场上1张魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--古代の機械熱核竜
function c44874522.initial_effect(c)
	--mat check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c44874522.valcheck)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c44874522.regcon)
	e2:SetOperation(c44874522.regop)
	c:RegisterEffect(e2)
	e2:SetLabelObject(e1)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetValue(c44874522.aclimit)
	e3:SetCondition(c44874522.actcon)
	c:RegisterEffect(e3)
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(44874522,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetCondition(c44874522.condition)
	e4:SetTarget(c44874522.target)
	e4:SetOperation(c44874522.operation)
	c:RegisterEffect(e4)
end
function c44874522.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	local tc=g:GetFirst()
	while tc do
		if tc:IsSetCard(0x7) and tc:IsType(TYPE_MONSTER) then flag=bit.bor(flag,0x1) end
		if tc:IsSetCard(0x51) and tc:IsType(TYPE_MONSTER) then flag=bit.bor(flag,0x2) end
		tc=g:GetNext()
	end
	e:SetLabel(flag)
end
function c44874522.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c44874522.regop(e,tp,eg,ep,ev,re,r,rp)
	local flag=e:GetLabelObject():GetLabel()
	local c=e:GetHandler()
	if bit.band(flag,0x1)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
	if bit.band(flag,0x2)~=0 then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EXTRA_ATTACK)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e2)
	end
end
function c44874522.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) or re:IsActiveType(TYPE_MONSTER)
end
function c44874522.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c44874522.condition(e,tp,eg,ep,ev,re,r,rp)
	return aux.dsercon(e,tp,eg,ep,ev,re,r,rp) and Duel.GetAttacker()==e:GetHandler()
end
function c44874522.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c44874522.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44874522.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c44874522.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c44874522.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c44874522.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
