--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 铁巨人 大铁锤  (ID: 79185500)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 900 | DEF 3500
--
-- Effect Text:
-- 自己场上有「异次元超能人·星斗罗宾」「野兽战士 豹人」「凤王兽 铠楼罗」存在的场合，这张卡可以从手卡特殊召唤。这张卡只要在场上表侧表示存在，不能把表示形式变更。此外，1回合1次，选择自己场上1只怪兽才
-- 能发动。这个回合，选择的怪兽可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--鉄巨人アイアンハンマー
function c79185500.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c79185500.spcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(79185500,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c79185500.target)
	e3:SetOperation(c79185500.operation)
	c:RegisterEffect(e3)
end
function c79185500.spfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c79185500.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE,0)~=0
		and Duel.IsExistingMatchingCard(c79185500.spfilter,tp,LOCATION_ONFIELD,0,1,nil,80208158)
		and Duel.IsExistingMatchingCard(c79185500.spfilter,tp,LOCATION_ONFIELD,0,1,nil,16796157)
		and Duel.IsExistingMatchingCard(c79185500.spfilter,tp,LOCATION_ONFIELD,0,1,nil,43791861)
end
function c79185500.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsFaceup() and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c79185500.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
