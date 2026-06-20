--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 科技属 坦克幼虫  (ID: 74627016)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Insect
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 39
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把自己场上的这张卡作为「科技属」同调怪兽的同调素材的场合，可以把这张卡当作调整以外的怪兽使用。
-- ②：这张卡作为「科技属」同调怪兽的同调素材送去墓地的场合才能发动。在自己场上把1只「科技属衍生物」（机械族·地·1星·攻/守0）攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--TG タンク・ラーヴァ
function c74627016.initial_effect(c)
	--nontuner
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_NONTUNER)
	e1:SetValue(c74627016.tnval)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74627016,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCountLimit(1,74627016)
	e2:SetCondition(c74627016.tkcon)
	e2:SetTarget(c74627016.tktg)
	e2:SetOperation(c74627016.tkop)
	c:RegisterEffect(e2)
end
function c74627016.tnval(e,c)
	return e:GetHandler():IsControler(c:GetControler()) and c:IsSetCard(0x27)
end
function c74627016.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
		and e:GetHandler():GetReasonCard():IsSetCard(0x27)
end
function c74627016.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,74627017,0x27,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c74627016.tkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,74627017,0x27,TYPES_TOKEN_MONSTER,0,0,1,RACE_MACHINE,ATTRIBUTE_EARTH,POS_FACEUP_ATTACK) then return end
	local token=Duel.CreateToken(tp,74627017)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
