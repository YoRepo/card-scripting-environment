--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 传说的赌博师  (ID: 2196767)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 500 | DEF 1400
--
-- Effect Text:
-- 进行3次投掷硬币。
-- ●3次都是表的场合，对方场上怪兽全部破坏。
-- ●2次表的场合，对方手卡随机丢弃1张。
-- ●1次表的场合，自己场上存在的1张卡破坏。
-- ●3次都是里的场合，自己手卡全部丢弃。
-- 这个效果1回合只有1次在自己的主要阶段才能使用。
--[[ __CARD_HEADER_END__ ]]

--伝説の賭博師
function c2196767.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2196767,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_HANDES+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c2196767.destg)
	e1:SetOperation(c2196767.desop)
	c:RegisterEffect(e1)
end
function c2196767.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c2196767.desop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	if c1+c2+c3==3 then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif c1+c2+c3==2 then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	elseif c1+c2+c3==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_ONFIELD,0,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT)
	else
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	end
end
