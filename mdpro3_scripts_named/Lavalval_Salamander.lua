--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 熔岩谷火精龙  (ID: 67797569)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Dragon
-- Level 7
-- ATK 2600 | DEF 200
-- Setcode: 57
--
-- Effect Text:
-- 调整＋调整以外的炎属性怪兽1只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡同调召唤成功的场合才能发动。自己从卡组抽2张，那之后从手卡把包含炎属性怪兽的2张卡送去墓地。手卡没有炎属性怪兽的场合，手卡全部公开，回到卡组。
-- ②：1回合1次，从自己墓地把1只炎属性怪兽除外才能发动。选最多有自己场上的「熔岩」怪兽数量的对方场上的表侧表示怪兽变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--ラヴァルバル・サラマンダー
function c67797569.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_FIRE),1)
	c:EnableReviveLimit()
	--Draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67797569,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,67797569)
	e1:SetCondition(c67797569.drcon)
	e1:SetTarget(c67797569.drtg)
	e1:SetOperation(c67797569.drop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67797569,1))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c67797569.cost)
	e2:SetTarget(c67797569.settg)
	e2:SetOperation(c67797569.setop)
	c:RegisterEffect(e2)
end
function c67797569.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c67797569.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c67797569.tgcheck(g)
	return g:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_FIRE)
end
function c67797569.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.BreakEffect()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tg=g:SelectSubGroup(tp,c67797569.tgcheck,false,2,2)
	if tg then
		if Duel.SendtoGrave(tg,REASON_EFFECT)==0 then
			Duel.ShuffleHand(p)
		end
	else
		local sg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
		Duel.ConfirmCards(1-p,sg)
		Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c67797569.refilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c67797569.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67797569.refilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c67797569.refilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c67797569.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x39)
end
function c67797569.posfilter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c67797569.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67797569.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c67797569.posfilter,tp,0,LOCATION_MZONE,1,nil) end
end
function c67797569.setop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c67797569.cfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c67797569.posfilter,tp,0,LOCATION_MZONE,1,ct,nil)
	if #g>0 then
		Duel.HintSelection(g)
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
