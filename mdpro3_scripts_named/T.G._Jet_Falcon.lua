--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 科技属 喷气猎鹰  (ID: 37300735)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Winged Beast
-- Level 3
-- ATK 1400 | DEF 1200
-- Setcode: 39
--
-- Effect Text:
-- 这张卡作为同调召唤的素材送去墓地的场合，给与对方基本分500分伤害。
--[[ __CARD_HEADER_END__ ]]

--TG ジェット・ファルコン
function c37300735.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37300735,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c37300735.damcon)
	e1:SetTarget(c37300735.damtg)
	e1:SetOperation(c37300735.damop)
	c:RegisterEffect(e1)
end
function c37300735.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c37300735.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c37300735.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
