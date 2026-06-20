--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 疾行机人 吹持童子  (ID: 50482813)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 1000 | DEF 1000
-- Setcode: 8214
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。把这张卡以外的自己场上的风属性怪兽数量的卡从自己卡组上面翻开，从那之中选1张加入手卡，剩下的卡用喜欢的顺序回到卡组最下面。
-- ②：把墓地的这张卡除外，以自己场上1只3星以上的风属性怪兽为对象才能发动。那只怪兽的等级下降2星。
--[[ __CARD_HEADER_END__ ]]

--SR吹持童子
function c50482813.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50482813,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,50482813)
	e1:SetTarget(c50482813.thtg)
	e1:SetOperation(c50482813.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--decrease level
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(50482813,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,50482814)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c50482813.target)
	e3:SetOperation(c50482813.operation)
	c:RegisterEffect(e3)
end
function c50482813.cfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WIND)
end
function c50482813.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c50482813.cfilter,tp,LOCATION_MZONE,0,e:GetHandler())
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=ct
		and Duel.GetDecktopGroup(tp,ct):IsExists(Card.IsAbleToHand,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c50482813.thop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c50482813.cfilter,tp,LOCATION_MZONE,0,aux.ExceptThisCard(e))
	Duel.ConfirmDecktop(tp,ct)
	local g=Duel.GetDecktopGroup(tp,ct)
	if #g>0 then
		Duel.DisableShuffleCheck()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		if sc:IsAbleToHand() then
			Duel.SendtoHand(sc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sc)
			Duel.ShuffleHand(tp)
		else
			Duel.SendtoGrave(sc,REASON_RULE)
		end
	end
	if #g>1 then
		Duel.SortDecktop(tp,tp,#g-1)
		for i=1,#g-1 do
			local dg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(dg:GetFirst(),SEQ_DECKBOTTOM)
		end
	end
end
function c50482813.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(3) and c:IsAttribute(ATTRIBUTE_WIND)
end
function c50482813.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c50482813.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c50482813.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c50482813.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c50482813.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
