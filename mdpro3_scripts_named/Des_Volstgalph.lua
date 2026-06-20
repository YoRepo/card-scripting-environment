--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 死亡魔导龙  (ID: 81059524)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dragon
-- Level 6
-- ATK 2200 | DEF 1700
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽送去墓地的场合发动。给与对方500伤害。
-- ②：只要这张卡在怪兽区域存在，每次自己或者对方把通常·速攻魔法卡发动，直到回合结束时这张卡的攻击力上升各200。
--[[ __CARD_HEADER_END__ ]]

--デス・ヴォルストガルフ
function c81059524.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81059524,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c81059524.damcon)
	e1:SetTarget(c81059524.damtg)
	e1:SetOperation(c81059524.damop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(aux.chainreg)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetCondition(c81059524.atkcon)
	e3:SetOperation(c81059524.atkop)
	c:RegisterEffect(e3)
end
function c81059524.damcon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc:IsType(TYPE_MONSTER) and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE)
end
function c81059524.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c81059524.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c81059524.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tpe=re:GetActiveType()
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and (tpe==TYPE_SPELL or tpe==TYPE_QUICKPLAY+TYPE_SPELL) and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0
end
function c81059524.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(200)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
