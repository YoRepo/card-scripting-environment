--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 绝火之魔神 琐罗亚  (ID: 95911373)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Spellcaster
-- Level 8
-- ATK 2900 | DEF 1500
-- Setcode: 336
--
-- Effect Text:
-- 魔法师族调整＋调整以外的怪兽1只以上
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡同调召唤成功的场合才能发动。从额外卡组把1只「大贤者」怪兽当作装备卡使用给这张卡装备。
-- ②：对方不能把和自己的魔法与陷阱区域的「大贤者」怪兽卡相同种类（融合·同调·超量·连接）的怪兽的效果发动。
-- ③：以自己场上1张「大贤者」卡为对象才能发动。那张卡破坏，这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--絶火の魔神ゾロア
function c95911373.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95911373,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c95911373.eqcon)
	e1:SetTarget(c95911373.eqtg)
	e1:SetOperation(c95911373.eqop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(c95911373.actlimit)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95911373,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,95911373)
	e3:SetTarget(c95911373.sptg)
	e3:SetOperation(c95911373.spop)
	c:RegisterEffect(e3)
end
function c95911373.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c95911373.eqfilter(c,ec)
	return c:IsSetCard(0x150) and not c:IsForbidden()
end
function c95911373.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c95911373.eqfilter,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
end
function c95911373.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and c:IsFaceup()
		and c:IsRelateToEffect(e) and c:IsLocation(LOCATION_MZONE) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c95911373.eqfilter,tp,LOCATION_EXTRA,0,1,1,nil,c)
		if g:GetCount()>0 then
			Duel.Equip(tp,g:GetFirst(),c)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(c95911373.eqlimit)
			e1:SetLabelObject(c)
			g:GetFirst():RegisterEffect(e1)
		end
	end
end
function c95911373.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c95911373.cfilter(c,rtype)
	return c:IsFaceup() and c:IsSetCard(0x150) and c:GetOriginalType()&rtype>0
end
function c95911373.actlimit(e,re,rp)
	local tp=e:GetHandlerPlayer()
	local rtype=bit.band(re:GetHandler():GetType(),TYPE_FUSION|TYPE_SYNCHRO|TYPE_XYZ|TYPE_LINK)
	return re:IsActiveType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(c95911373.cfilter,tp,LOCATION_SZONE,0,1,nil,rtype)
end
function c95911373.desfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x150) and Duel.GetMZoneCount(tp,c)>0
end
function c95911373.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c95911373.desfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c95911373.desfilter,tp,LOCATION_ONFIELD,0,1,nil,tp)
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c95911373.desfilter,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c95911373.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		local c=e:GetHandler()
		if c:IsRelateToEffect(e) then
			Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
