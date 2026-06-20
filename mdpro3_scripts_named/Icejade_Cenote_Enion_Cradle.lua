--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 冰水底 铬离子少女摇篮  (ID: 7142724)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 364
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以把自己的墓地·除外状态的1只「冰水」怪兽加入手卡。
-- ②：1回合1次，怪兽召唤·特殊召唤的场合，以自己场上1只水属性怪兽为对象才能发动。作为对象的怪兽以及对方场上的全部表侧表示怪兽的攻击力直到回合结束时下降作为对象的怪兽的原本攻击力数值。
--[[ __CARD_HEADER_END__ ]]

--氷水底イニオン・クレイドル
function c7142724.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,7142724+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c7142724.activate)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7142724,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_SINGLE)
	e2:SetTarget(c7142724.adtg)
	e2:SetOperation(c7142724.adop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c7142724.thfilter(c)
	return c:IsSetCard(0x16c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
		and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c7142724.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c7142724.thfilter),tp,LOCATION_GRAVE+LOCATION_REMOVED,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(7142724,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c7142724.adfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsFaceup() and c:GetBaseAttack()>0
end
function c7142724.adtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c7142724.adfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c7142724.adfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c7142724.adfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,0)
end
function c7142724.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	g:AddCard(tc)
	local tc1=g:GetFirst()
	while tc1 do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(-tc:GetBaseAttack())
		tc1:RegisterEffect(e1)
		tc1=g:GetNext()
	end
end
