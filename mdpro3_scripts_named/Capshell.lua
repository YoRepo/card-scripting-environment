--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 扭蛋魔壳  (ID: 76722334)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 2
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②③的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡被解放的场合才能发动。自己抽1张。
-- ②：这张卡成为融合·同调·连接召唤的素材，被送去墓地的场合或者被除外的场合才能发动。自己抽1张。
-- ③：超量素材的这张卡为让超量怪兽的效果发动而被取除的场合才能发动。自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--カプシェル
function c76722334.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76722334,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_RELEASE)
	e1:SetCountLimit(1,76722334)
	e1:SetTarget(c76722334.drtg)
	e1:SetOperation(c76722334.drop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c76722334.drcon1)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c76722334.drcon2)
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EVENT_REMOVE)
	e4:SetCondition(c76722334.drcon2)
	c:RegisterEffect(e4)
end
function c76722334.drcon1(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_FUSION+REASON_SYNCHRO+REASON_LINK)~=0 and not e:GetHandler():IsReason(REASON_RETURN)
end
function c76722334.drcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_COST) and re:IsActivated() and re:IsActiveType(TYPE_XYZ)
		and c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c76722334.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c76722334.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
