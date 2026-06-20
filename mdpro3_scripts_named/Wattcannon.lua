--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 电气大炮  (ID: 95084054)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 14
--
-- Effect Text:
-- 场上有4星以下的雷族怪兽召唤·特殊召唤时，给与对方基本分600分伤害。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--エレキャノン
function c95084054.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95084054,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetCondition(c95084054.damcon)
	e2:SetTarget(c95084054.damtg)
	e2:SetOperation(c95084054.damop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c95084054.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(4) and c:IsRace(RACE_THUNDER)
end
function c95084054.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c95084054.filter,1,nil)
end
function c95084054.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function c95084054.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
