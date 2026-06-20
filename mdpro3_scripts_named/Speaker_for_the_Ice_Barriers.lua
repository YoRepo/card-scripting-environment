--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 冰结界的依巫  (ID: 44308317)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 47
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：自己场上有「冰结界」怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：只要自己场上有其他的「冰结界」怪兽存在，对方场上的守备表示怪兽不能把表示形式变更。
-- ③：自己场上有「冰结界」怪兽存在的场合，把墓地的这张卡除外才能发动。在自己场上把1只「冰结界衍生物」（水族·水·1星·攻/守0）特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--氷結界の依巫
function c44308317.initial_effect(c)
	--Cannot Change a Battle Position
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c44308317.postg)
	e1:SetCondition(c44308317.poscon)
	c:RegisterEffect(e1)
	--Special Summon from a hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44308317,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,44308317)
	e2:SetCondition(c44308317.spcon)
	e2:SetTarget(c44308317.sptg)
	e2:SetOperation(c44308317.spop)
	c:RegisterEffect(e2)
	--Special Summon a Token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(44308317,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,44308318)
	e3:SetCost(aux.bfgcost)
	e3:SetCondition(c44308317.tkcon)
	e3:SetTarget(c44308317.tktg)
	e3:SetOperation(c44308317.tkop)
	c:RegisterEffect(e3)
end
function c44308317.posfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2f)
end
function c44308317.poscon(e)
	return Duel.IsExistingMatchingCard(c44308317.posfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c44308317.postg(e,c)
	return c:IsDefensePos()
end
function c44308317.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2f)
end
function c44308317.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44308317.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44308317.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44308317.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c44308317.tkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2f)
end
function c44308317.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c44308317.tkfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c44308317.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,44308318,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_AQUA,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c44308317.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,44308318,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_AQUA,ATTRIBUTE_WATER) then
		local token=Duel.CreateToken(tp,44308318)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
