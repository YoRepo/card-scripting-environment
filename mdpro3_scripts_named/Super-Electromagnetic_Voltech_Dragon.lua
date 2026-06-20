--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 超电磁稼动伏特龙  (ID: 20529766)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 5
-- ATK 2400 | DEF 1000
--
-- Effect Text:
-- 用以下的怪兽为祭品作祭品召唤的场合，这张卡得到各自的效果。
-- ●电池人-单1型：以这1张卡为对象的魔法·陷阱卡的效果无效。
-- ●电池人-单2型：这张卡攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。
-- ●电池人-单3型：这张卡攻击力上升1000。
--[[ __CARD_HEADER_END__ ]]

--超電磁稼動ボルテック・ドラゴン
function c20529766.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c20529766.condition)
	e1:SetOperation(c20529766.operation)
	c:RegisterEffect(e1)
	--tribute check
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c20529766.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c20529766.valcheck(e,c)
	local g=c:GetMaterial()
	local flag=0
	local tc=g:GetFirst()
	while tc do
		local code=tc:GetCode()
		if code==55401221 then flag=bit.bor(flag,0x1)
		elseif code==19733961 then flag=bit.bor(flag,0x2)
		elseif code==63142001 then flag=bit.bor(flag,0x4)
		end
		tc=g:GetNext()
	end
	e:GetLabelObject():SetLabel(flag)
end
function c20529766.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_ADVANCE) and e:GetLabel()~=0
end
function c20529766.operation(e,tp,eg,ep,ev,re,r,rp)
	local flag=e:GetLabel()
	local c=e:GetHandler()
	if bit.band(flag,0x1)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_SOLVING)
		e1:SetRange(LOCATION_MZONE)
		e1:SetOperation(c20529766.disop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
	if bit.band(flag,0x2)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
	if bit.band(flag,0x4)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c20529766.disop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_MONSTER) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if g:GetCount()==1 and g:GetFirst()==e:GetHandler() then
		Duel.NegateEffect(ev)
	end
end
