--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 半魔导带域  (ID: 71650854)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己的主要阶段1·主要阶段2的开始时才能把这张卡发动。
-- ①：双方的主要阶段1内，场上的怪兽不会成为各自的对方的效果的对象，不会被各自的对方的效果破坏。
-- ②：只要这张卡在场地区域存在，自己不能把场地魔法卡发动·盖放。
--[[ __CARD_HEADER_END__ ]]

--半魔導帯域
function c71650854.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c71650854.condition)
	c:RegisterEffect(e1)
	--indes/target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c71650854.indcon)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetValue(aux.indoval)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetValue(aux.tgsval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e5:SetValue(aux.indsval)
	c:RegisterEffect(e5)
	--cannot set/activate
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_CANNOT_SSET)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetRange(LOCATION_FZONE)
	e6:SetTargetRange(1,0)
	e6:SetTarget(c71650854.setlimit)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_ACTIVATE)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetRange(LOCATION_FZONE)
	e7:SetTargetRange(1,0)
	e7:SetValue(c71650854.actlimit)
	c:RegisterEffect(e7)
end
function c71650854.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
		and (not Duel.CheckPhaseActivity() or Duel.GetFlagEffect(tp,15248873)>0)
end
function c71650854.indcon(e)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c71650854.setlimit(e,c,tp)
	return c:IsType(TYPE_FIELD)
end
function c71650854.actlimit(e,re,tp)
	return re:IsActiveType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
