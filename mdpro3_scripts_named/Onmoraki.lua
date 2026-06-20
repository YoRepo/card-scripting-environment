--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 阴魔罗鬼  (ID: 95990456)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Zombie
-- Level 4
-- ATK 1200 | DEF 1000
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡被对方的效果破坏送去墓地的场合或者从墓地的特殊召唤成功的场合才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--陰魔羅鬼
function c95990456.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,95990456)
	e1:SetCondition(c95990456.drcon1)
	e1:SetTarget(c95990456.drtg)
	e1:SetOperation(c95990456.drop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c95990456.drcon2)
	c:RegisterEffect(e2)
end
function c95990456.drcon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousControler(tp) and c:IsReason(REASON_DESTROY)
		and c:IsReason(REASON_EFFECT) and rp==1-tp
end
function c95990456.drcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_GRAVE)
end
function c95990456.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c95990456.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
