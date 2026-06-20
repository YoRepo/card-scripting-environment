--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 冰水咒缚  (ID: 83670388)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 364
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要场上有「冰水」怪兽以及「冰水底 铬离子少女摇篮」存在，对方不能把这个回合召唤·反转召唤·特殊召唤的场上的怪兽的效果发动。
-- ②：自己的「冰水」怪兽的战斗让怪兽被破坏时，以那1只破坏的怪兽为对象才能发动。给与对方那只怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--氷水呪縛
function c83670388.initial_effect(c)
	aux.AddCodeList(c,7142724)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--act limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetCondition(c83670388.actcon)
	e2:SetValue(c83670388.aclimit)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,83670388)
	e3:SetCondition(c83670388.damcon)
	e3:SetTarget(c83670388.damtg)
	e3:SetOperation(c83670388.damop)
	c:RegisterEffect(e3)
end
function c83670388.actfilter(c)
	return c:IsSetCard(0x16c) and c:IsFaceup()
end
function c83670388.actcon(e)
	return Duel.IsExistingMatchingCard(c83670388.actfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsEnvironment(7142724)
end
function c83670388.aclimit(e,re,tp)
	local rc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and rc:IsLocation(LOCATION_MZONE)
		and rc:IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
function c83670388.damcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetBattleMonster(tp)
	return a and a:IsSetCard(0x16c)
end
function c83670388.damfilter(c,e)
	return c:GetBaseAttack()>0 and c:IsCanBeEffectTarget(e) and c:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED)
end
function c83670388.damtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c83670388.filter(chkc,e,tp) end
	if chk==0 then return eg:IsExists(c83670388.damfilter,1,nil,e) end
	local g=eg
	if #eg>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		e=eg:FilterSelect(tp,c83670388.damfilter,1,1,nil,e)
	end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetFirst():GetBaseAttack())
end
function c83670388.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
	end
end
