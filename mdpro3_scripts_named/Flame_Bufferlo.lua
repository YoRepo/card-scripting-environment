--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 帧缓存火牛  (ID: 80794697)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Cyberse
-- Level 3
-- ATK 1400 | DEF 200
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：表侧表示的这张卡从场上离开的场合才能发动。从手卡丢弃1只电子界族怪兽，自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--フレイム・バッファロー
function c80794697.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80794697,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,80794697)
	e1:SetCondition(c80794697.condition)
	e1:SetTarget(c80794697.target)
	e1:SetOperation(c80794697.operation)
	c:RegisterEffect(e1)
end
function c80794697.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c80794697.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_CYBERSE) and c:IsDiscardable()
end
function c80794697.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c80794697.tgfilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c80794697.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,c80794697.tgfilter,1,1,REASON_EFFECT+REASON_DISCARD)~=0 then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
