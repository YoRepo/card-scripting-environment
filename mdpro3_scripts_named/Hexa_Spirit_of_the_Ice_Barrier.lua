--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 冰结界的霜精  (ID: 70703416)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Sea Serpent
-- Level 1
-- ATK 400 | DEF 200
-- Setcode: 47
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要自己场上有其他的「冰结界」怪兽存在，对方场上的怪兽的攻击力·守备力下降500。
-- ②：自己主要阶段才能发动。从卡组把1只3星以下的「冰结界」怪兽送去墓地。这张卡的等级直到回合结束时变成和那只怪兽相同。
--[[ __CARD_HEADER_END__ ]]

--氷結界の霜精
function c70703416.initial_effect(c)
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(-500)
	e1:SetCondition(c70703416.atkcon)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--lv
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(70703416,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,70703416)
	e3:SetTarget(c70703416.lvtg)
	e3:SetOperation(c70703416.lvop)
	c:RegisterEffect(e3)
end
function c70703416.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2f)
end
function c70703416.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c70703416.atkfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c70703416.tgfilter(c)
	return c:IsLevelBelow(3) and c:IsSetCard(0x2f) and c:IsAbleToGrave()
end
function c70703416.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70703416.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c70703416.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c70703416.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
