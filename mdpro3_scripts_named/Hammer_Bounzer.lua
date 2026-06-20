--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 重锤突击保镖  (ID: 44790889)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 2300 | DEF 2000
-- Setcode: 107
--
-- Effect Text:
-- 对方场上有卡存在，自己场上没有卡存在的场合，这张卡可以不用解放作召唤。自己场上没有魔法·陷阱卡存在，这张卡向对方怪兽攻击的场合，对方直到伤害步骤结束时魔法·陷阱卡不能发动。
--[[ __CARD_HEADER_END__ ]]

--ハンマーラッシュ・バウンサー
function c44790889.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44790889,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c44790889.ntcon)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c44790889.aclimit)
	e2:SetCondition(c44790889.actcon)
	c:RegisterEffect(e2)
end
function c44790889.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,0)==0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_ONFIELD)>0
end
function c44790889.actcon(e)
	return Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil
		and not Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c44790889.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
