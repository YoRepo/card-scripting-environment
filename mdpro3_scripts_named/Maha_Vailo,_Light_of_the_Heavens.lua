--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 光天之摩诃毗卢  (ID: 45796834)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 8
-- ATK 1550 | DEF 1400
--
-- Effect Text:
-- ①：这张卡得到这张卡的装备卡数量的以下效果。
-- ●1张以上：这张卡的攻击力上升这张卡的装备卡数量×1000。
-- ●2张以上：对方在战斗阶段中不能把怪兽的效果发动。
-- ●3张以上：这张卡为对象的对方的效果发动时，把自己场上1张装备卡送去墓地才能发动。那个效果无效。
-- ●4张以上：对方在战斗阶段中不能把卡的效果发动。
-- ●5张以上：这张卡给与对方的战斗伤害变成2倍。
--[[ __CARD_HEADER_END__ ]]

--光天のマハー・ヴァイロ
function c45796834.initial_effect(c)
	--atk boost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetLabel(1)
	e1:SetCondition(c45796834.eqcon)
	e1:SetValue(c45796834.atkval)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetLabel(2)
	e2:SetCondition(c45796834.eqcon)
	e2:SetValue(c45796834.actlimit)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabel(3)
	e3:SetCondition(c45796834.eqcon)
	e3:SetCost(c45796834.negcost)
	e3:SetTarget(c45796834.negtg)
	e3:SetOperation(c45796834.negop)
	c:RegisterEffect(e3)
	--actlimit2
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetTargetRange(0,1)
	e4:SetLabel(4)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c45796834.eqcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--double damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e5:SetLabel(5)
	e5:SetCondition(c45796834.eqcon)
	e5:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e5)
end
function c45796834.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lab=e:GetLabel()
	if c:GetEquipCount()<lab then return false end
	if (lab==2 or lab==4) then
		return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
	elseif lab==3 then
		if rp==tp or c:IsStatus(STATUS_BATTLE_DESTROYED) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
			return false
		end
		local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
		return g and g:IsContains(c) and Duel.IsChainDisablable(ev)
	else
		return true
	end
end
function c45796834.atkval(e,c)
	return c:GetEquipCount()*1000
end
function c45796834.actlimit(e,re,rp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c45796834.negfilter(c)
	return (c:IsFaceup() or c:GetEquipTarget()) and c:IsType(TYPE_EQUIP) and c:IsAbleToGraveAsCost()
end
function c45796834.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c45796834.negfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c45796834.negfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c45796834.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c45796834.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
