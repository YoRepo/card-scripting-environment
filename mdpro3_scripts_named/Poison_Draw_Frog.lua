--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 抽卡青蛙  (ID: 56840658)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 2
-- ATK 100 | DEF 100
-- Setcode: 18
--
-- Effect Text:
-- 场上表侧表示的这张卡被送去墓地时，可以从自己卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--引きガエル
function c56840658.initial_effect(c)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(56840658,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c56840658.condition)
	e2:SetTarget(c56840658.target)
	e2:SetOperation(c56840658.operation)
	c:RegisterEffect(e2)
end
function c56840658.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c56840658.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c56840658.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
