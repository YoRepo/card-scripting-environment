--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 进化结末光焰  (ID: 78217065)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1张「超载融合」加入手卡。这个回合中，「超载融合」的效果用6只以上的怪兽为素材作融合召唤的场合，那只怪兽在这个回合在同1次的战斗阶段中可以作出最多有那些作为融合素材的怪兽数量的攻击。这张卡
-- 的发动后，直到回合结束时自己不用魔法卡的效果不能把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エヴォリューション・レザルト・バースト
function c78217065.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,78217065+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c78217065.target)
	e1:SetOperation(c78217065.activate)
	c:RegisterEffect(e1)
end
function c78217065.thfilter(c)
	return c:IsCode(3659803) and c:IsAbleToHand()
end
function c78217065.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c78217065.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c78217065.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c78217065.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
	--extra attack
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c78217065.excon)
	e1:SetOperation(c78217065.exop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	--sumlimit
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c78217065.splimit)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c78217065.cfilter(c)
	return c:IsType(TYPE_FUSION) and c:IsSummonType(SUMMON_TYPE_FUSION) and c:GetMaterialCount()>=6
end
function c78217065.excon(e,tp,eg,ep,ev,re,r,rp)
	return re and re:GetHandler():IsCode(3659803) and eg:IsExists(c78217065.cfilter,1,nil)
end
function c78217065.exop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:Filter(c78217065.cfilter,nil):GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(tc:GetMaterialCount()-1)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	tc:RegisterEffect(e1)
end
function c78217065.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not se:GetHandler():IsType(TYPE_SPELL)
end
