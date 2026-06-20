--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 扰乱·粉  (ID: 42517468)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 2
-- ATK 0 | DEF 1000
-- Setcode: 15
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡从手卡·场上送去墓地的场合才能发动。双方玩家从卡组抽1张，那之后选1张手卡丢弃。这个效果让自己把「扰乱」卡丢弃的场合，可以再指定没有使用的对方的怪兽区域1处。那个区域直到对方回合结束时不能使
-- 用。
--[[ __CARD_HEADER_END__ ]]

--おジャマ・ピンク
function c42517468.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42517468,1))
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,42517468)
	e1:SetCondition(c42517468.thcon)
	e1:SetTarget(c42517468.target)
	e1:SetOperation(c42517468.activate)
	c:RegisterEffect(e1)
end
function c42517468.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND+LOCATION_ONFIELD)
end
function c42517468.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,1)
end
function c42517468.activate(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.Draw(tp,1,REASON_EFFECT)
	local h2=Duel.Draw(1-tp,1,REASON_EFFECT)
	if h1>0 or h2>0 then Duel.BreakEffect() end
	local groundcollapse=false
	if h1>0 then
		Duel.ShuffleHand(tp)
		Duel.DiscardHand(tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
		local dc=Duel.GetOperatedGroup():GetFirst()
		if dc:IsSetCard(0xf) then groundcollapse=true end
	end
	if h2>0 then
		Duel.ShuffleHand(1-tp)
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
	end
	if groundcollapse and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(42517468,0)) then
		Duel.BreakEffect()
		local zone=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
		if tp==1 then
			zone=((zone&0xffff)<<16)|((zone>>16)&0xffff)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DISABLE_FIELD)
		e1:SetValue(zone)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
	end
end
