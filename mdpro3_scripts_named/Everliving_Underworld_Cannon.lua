--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 不死式冥界炮  (ID: 31467372)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有不死族怪兽特殊召唤时，给与对方基本分800分伤害。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--不死式冥界砲
function c31467372.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(31467372,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c31467372.damcon)
	e2:SetTarget(c31467372.damtg)
	e2:SetOperation(c31467372.damop)
	c:RegisterEffect(e2)
end
function c31467372.filter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsRace(RACE_ZOMBIE)
end
function c31467372.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c31467372.filter,1,nil,tp)
end
function c31467372.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c31467372.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
