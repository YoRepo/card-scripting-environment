--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 古代的机械巨龙  (ID: 50933533)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- ATK 3000 | DEF 2000
-- Setcode: 7
--
-- Effect Text:
-- ①：得到为这张卡的召唤而解放的怪兽的以下效果。
-- ●绿色零件：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ●红色零件：这张卡给与对方战斗伤害的场合发动。给与对方400伤害。
-- ●黄色零件：这张卡战斗破坏对方怪兽的场合发动。给与对方600伤害。
-- ②：这张卡攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--古代の機械巨竜
function c50933533.initial_effect(c)
	aux.AddCodeList(c,41172955,86445415,13839120)
	--mat check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c50933533.valcheck)
	c:RegisterEffect(e1)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c50933533.regcon)
	e2:SetOperation(c50933533.regop)
	c:RegisterEffect(e2)
	e2:SetLabelObject(e1)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_ACTIVATE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,1)
	e3:SetValue(c50933533.aclimit)
	e3:SetCondition(c50933533.actcon)
	c:RegisterEffect(e3)
end
function c50933533.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c50933533.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c50933533.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetCode()
		if code==41172955 then flag=bit.bor(flag,0x1)
		elseif code==86445415 then flag=bit.bor(flag,0x2)
		elseif code==13839120 then flag=bit.bor(flag,0x4)
		end
		tc=g:GetNext()
	end
	e:SetLabel(flag)
end
function c50933533.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c50933533.regop(e,tp,eg,ep,ev,re,r,rp)
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
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(50933533,0))
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EVENT_BATTLE_DAMAGE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCondition(c50933533.damcon1)
		e1:SetTarget(c50933533.damtg1)
		e1:SetOperation(c50933533.damop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
	if bit.band(flag,0x4)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(50933533,1))
		e1:SetCategory(CATEGORY_DAMAGE)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EVENT_BATTLE_DESTROYING)
		e1:SetTarget(c50933533.damtg2)
		e1:SetOperation(c50933533.damop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
end
function c50933533.damcon1(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c50933533.damtg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,400)
end
function c50933533.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function c50933533.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
