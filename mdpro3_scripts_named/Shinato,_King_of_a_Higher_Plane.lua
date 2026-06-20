--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 天界王 志那都  (ID: 86327225)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fairy
-- Level 8
-- ATK 3300 | DEF 3000
--
-- Effect Text:
-- 用「奇迹之方舟」特殊召唤。特殊召唤时，必须以场上或手卡中合计8颗星以上的怪兽作为祭品。这张卡战斗破坏对方守备表示的怪兽并将其送去墓地时，对方受到数值与被破坏怪兽的原本攻击力相同的伤害。
--[[ __CARD_HEADER_END__ ]]

--天界王 シナト
function c86327225.initial_effect(c)
	aux.AddCodeList(c,60365591)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86327225,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c86327225.damcon)
	e1:SetTarget(c86327225.damtg)
	e1:SetOperation(c86327225.damop)
	c:RegisterEffect(e1)
end
function c86327225.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
		and bit.band(bc:GetBattlePosition(),POS_DEFENSE)~=0
end
function c86327225.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local dam=bc:GetBaseAttack()
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c86327225.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
