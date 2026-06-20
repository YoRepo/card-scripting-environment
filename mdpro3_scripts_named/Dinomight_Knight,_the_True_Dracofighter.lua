--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 真龙拳士 雾动轰·铁拳  (ID: 58984738)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Wyrm
-- Level 6
-- ATK 2500 | DEF 1200
-- Setcode: 249
--
-- Effect Text:
-- 这张卡表侧表示上级召唤的场合，可以作为怪兽的代替而把自己场上的永续魔法·永续陷阱卡解放。
-- ①：这张卡是已上级召唤的场合，1回合1次，对方把魔法·陷阱·怪兽的效果发动时才能发动。从卡组选1张「真龙」永续陷阱卡加入手卡或在自己场上发动。
--[[ __CARD_HEADER_END__ ]]

--真竜拳士ダイナマイトK
function c58984738.initial_effect(c)
	--summon with s/t
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_ADD_EXTRA_TRIBUTE)
	e1:SetTargetRange(LOCATION_SZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_CONTINUOUS))
	e1:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(58984738,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c58984738.thcon)
	e2:SetTarget(c58984738.thtg)
	e2:SetOperation(c58984738.thop)
	c:RegisterEffect(e2)
end
function c58984738.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE) and rp==1-tp
end
function c58984738.thfilter(c,tp)
	return c:IsSetCard(0xf9) and c:GetType()==0x20004
		and (c:IsAbleToHand() or c:GetActivateEffect():IsActivatable(tp))
end
function c58984738.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c58984738.thfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c58984738.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c58984738.thfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	local tc=g:GetFirst()
	if tc then
		local b1=tc:IsAbleToHand()
		local b2=tc:GetActivateEffect():IsActivatable(tp)
		if b1 and (not b2 or Duel.SelectOption(tp,1190,1150)==0) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local te=tc:GetActivateEffect()
			local tep=tc:GetControler()
			local cost=te:GetCost()
			if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		end
	end
end
