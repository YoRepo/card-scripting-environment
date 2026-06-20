--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 灾害恶魔  (ID: 29603180)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 9
-- ATK 2000 | DEF 3000
-- Setcode: 69
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：以自己以及对方场上的卡各1张为对象才能发动。那些卡破坏。这个效果把表侧表示的恶魔族怪兽破坏的场合，这张卡的攻击力直到回合结束时上升那些怪兽的原本攻击力合计数值的一半。
--[[ __CARD_HEADER_END__ ]]

--ディザスター・デーモン
function c29603180.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29603180,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,29603180)
	e1:SetTarget(c29603180.destg)
	e1:SetOperation(c29603180.desop)
	c:RegisterEffect(e1)
end
function c29603180.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,0,1,nil) and Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c29603180.atkfilter(c)
	return c:IsPreviousPosition(POS_FACEUP) and bit.band(c:GetPreviousRaceOnField(),RACE_FIEND)~=0
end
function c29603180.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 and Duel.Destroy(tg,REASON_EFFECT)~=0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local og=Duel.GetOperatedGroup()
		local ag=og:Filter(c29603180.atkfilter,nil)
		local atk=ag:GetSum(Card.GetTextAttack)/2
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
