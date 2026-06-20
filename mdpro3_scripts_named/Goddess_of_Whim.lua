--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 任性的女神  (ID: 67959180)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 3
-- ATK 950 | DEF 700
--
-- Effect Text:
-- ①：1回合1次，自己主要阶段才能发动。进行1次投掷硬币，对里表作猜测。猜中的场合，这张卡的攻击力直到回合结束时变成2倍。猜错的场合，这张卡的攻击力直到回合结束时变成一半。
--[[ __CARD_HEADER_END__ ]]

--きまぐれの女神
function c67959180.initial_effect(c)
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67959180,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c67959180.target)
	e1:SetOperation(c67959180.operation)
	c:RegisterEffect(e1)
end
function c67959180.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c67959180.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
		local opt=Duel.AnnounceCoin(tp)
		local coin=Duel.TossCoin(tp,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		if opt==coin then
			e1:SetValue(math.ceil(c:GetAttack()/2))
		else
			e1:SetValue(c:GetAttack()*2)
		end
		c:RegisterEffect(e1)
	end
end
