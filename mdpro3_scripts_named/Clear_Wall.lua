--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 清透壁  (ID: 6089145)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：场上有「清透世界」存在的场合才能发动。从卡组把有「清透世界」的卡名记述的1只怪兽加入手卡。
-- ②：有「清透世界」的卡名记述的怪兽不会被战斗破坏，那次战斗发生的对自己的战斗伤害变成0。
-- ③：只要有「清透世界」的卡名记述的7星以上的怪兽在自己场上存在，「清透世界」的效果不论属性而全部对对方适用。
--[[ __CARD_HEADER_END__ ]]

--クリアー・ウォール
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,33900648)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.thcon)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	--indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(s.indestg)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--avoid battle damage
	local e4=e3:Clone()
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e5)
	--affected
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(0,1)
	e6:SetCondition(s.ieecon)
	e6:SetCode(id)
	c:RegisterEffect(e6)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(33900648)
end
function s.thfilter(c)
	return aux.IsCodeListed(c,33900648) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.indestg(e,c)
	return aux.IsCodeListed(c,33900648)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsLevelAbove(7) and aux.IsCodeListed(c,33900648)
end
function s.ieecon(e)
	return Duel.IsExistingMatchingCard(s.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
