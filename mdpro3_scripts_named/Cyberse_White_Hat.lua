--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 电子界白帽客  (ID: 46104361)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level 6
-- ATK 1800 | DEF 2400
-- Setcode: 147
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有相同种族的怪兽2只以上存在的场合，这张卡可以从手卡特殊召唤。
-- ②：这张卡作为连接素材送去墓地的场合才能发动。对方场上的全部怪兽的攻击力直到回合结束时下降1000。
--[[ __CARD_HEADER_END__ ]]

--サイバース・ホワイトハット
function c46104361.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46104361,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,46104361+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c46104361.spcon)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46104361,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c46104361.atkcon)
	e2:SetTarget(c46104361.atktg)
	e2:SetOperation(c46104361.atkop)
	c:RegisterEffect(e2)
end
function c46104361.filter(c,tp,race)
	if c:IsFacedown() then return false end
	if not race then
		return Duel.IsExistingMatchingCard(c46104361.filter,tp,LOCATION_MZONE,0,1,c,tp,c:GetRace())
	else
		return c:IsRace(race)
	end
end
function c46104361.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c46104361.filter,c:GetControler(),LOCATION_MZONE,0,1,nil,c:GetControler())
end
function c46104361.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_LINK
end
function c46104361.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
end
function c46104361.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
