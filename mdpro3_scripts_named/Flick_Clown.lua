--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 滑动触控王冠人  (ID: 209710)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level 4
-- ATK 1000 | DEF 1400
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：自己场上有这张卡以外的电子界族怪兽2只以上存在，自己手卡是0张的场合，支付1000基本分才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--フリック・クラウン
function c209710.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(209710,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,209710)
	e1:SetCondition(c209710.drcon)
	e1:SetCost(c209710.drcost)
	e1:SetTarget(c209710.drtg)
	e1:SetOperation(c209710.drop)
	c:RegisterEffect(e1)
end
function c209710.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_CYBERSE)
end
function c209710.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c209710.cfilter,tp,LOCATION_MZONE,0,2,e:GetHandler())
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c209710.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c209710.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c209710.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
