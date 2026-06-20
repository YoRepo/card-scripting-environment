--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 噩梦之苦痛  (ID: 65261141)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。自己的手卡·场上（表侧表示）1只暗属性怪兽破坏，除「噩梦之苦痛」外的1只「于贝尔」或者1张有那个卡名记述的卡从卡组加入手卡。
-- ②：只要自己场上有「于贝尔」怪兽存在，可以攻击的对方怪兽必须向「于贝尔」怪兽作出攻击。
-- ③：自己的「于贝尔」怪兽的战斗发生的对自己的战斗伤害由对方代受。
--[[ __CARD_HEADER_END__ ]]

--ナイトメア・ペイン
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,78371393)
	aux.AddSetNameMonsterList(c,0x1a5)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,id)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	--must attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MUST_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(s.atkcon)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e4:SetValue(s.atklimit)
	c:RegisterEffect(e4)
	--reflect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetTarget(s.reftg)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function s.dfilter(c,e,tp)
	return c:IsFaceupEx() and c:IsType(TYPE_MONSTER) and c:IsAttribute(ATTRIBUTE_DARK)
end
function s.thfilter(c,code)
	return (c:IsCode(78371393) or aux.IsCodeListed(c,78371393)) and c:IsAbleToHand() and not c:IsCode(id)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.dfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,tp,LOCATION_HAND+LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,s.dfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil,e,tp)
	if Duel.Destroy(g,REASON_EFFECT)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tg=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil,e:GetHandler():GetCode())
	if #g>0 then
		Duel.SendtoHand(tg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg)
	end
end
function s.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1a5)
end
function s.atkcon(e)
	return Duel.IsExistingMatchingCard(s.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function s.atklimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x1a5)
end
function s.reftg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x1a5)
end
