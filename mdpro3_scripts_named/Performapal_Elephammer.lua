--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 娱乐伙伴 槌子巨象  (ID: 340002)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 6
-- ATK 2600 | DEF 1800
-- Setcode: 159
--
-- Effect Text:
-- ①：自己场上有「娱乐伙伴」卡2张以上存在的场合，这张卡可以不用解放作召唤。
-- ②：自己场上没有其他的「娱乐伙伴」卡存在的场合，这张卡不能攻击。
-- ③：这张卡的攻击宣言时才能发动。对方场上的魔法·陷阱卡全部回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--EMハンマーマンモ
function c340002.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(340002,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c340002.ntcon)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c340002.atkcon)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetTarget(c340002.thtg)
	e3:SetOperation(c340002.thop)
	c:RegisterEffect(e3)
end
function c340002.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f)
end
function c340002.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c340002.cfilter,c:GetControler(),LOCATION_ONFIELD,0,2,nil)
end
function c340002.atkcon(e)
	return not Duel.IsExistingMatchingCard(c340002.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,e:GetHandler())
end
function c340002.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c340002.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c340002.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c340002.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c340002.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c340002.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
