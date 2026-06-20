--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: No.85 狂箱  (ID: 42421606)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Fiend
-- Rank 4
-- ATK 3000 | DEF 300
-- Setcode: 72
--
-- Effect Text:
-- 4星怪兽×2
-- ①：这张卡不能攻击。
-- ②：1回合1次，把这张卡1个超量素材取除才能发动。掷1次骰子，出现的数目的以下效果适用。
-- ●1：自己基本分变成一半。
-- ●2：自己从卡组抽1张。
-- ●3：对方选1张手卡丢弃。
-- ●4：选场上1张表侧表示的卡，那个效果直到回合结束时无效。
-- ●5：选场上1张卡破坏。
-- ●6：这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--No.85 クレイジー・ボックス
function c42421606.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(42421606,0))
	e2:SetCategory(CATEGORY_DICE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c42421606.efcost)
	e2:SetTarget(c42421606.eftg)
	e2:SetOperation(c42421606.efop)
	c:RegisterEffect(e2)
end
aux.xyz_number[42421606]=85
function c42421606.efcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c42421606.eftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c42421606.efop(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.TossDice(tp,1)
	if dc==1 then
		Duel.SetLP(tp,math.ceil(Duel.GetLP(tp)/2))
	elseif dc==2 then
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif dc==3 then
		if Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 then
			Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
		end
	elseif dc==4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local tc=g:GetFirst()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
	elseif dc==5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	elseif dc==6 then
		if e:GetHandler():IsRelateToEffect(e) then
			Duel.Destroy(e:GetHandler(),REASON_EFFECT)
		end
	end
end
